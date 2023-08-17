import requests
import json
import os.path
from google.cloud import bigquery
from google.api_core import exceptions
import click


def get_data():
    pokemon_data = []

    pokemons = requests.get('https://pokeapi.co/api/v2/pokemon?limit=2000&offset=0').json()['results']

    for pokemon in pokemons:
        p = {'name': pokemon['name'], 'url': pokemon['url']}

        resp = requests.get(pokemon['url']).json()
        p['data'] = resp

        pokemon_data.append(p)

    return pokemon_data


def write_to_disk(poke_data, path):
    with open(path, 'w') as outfile:
        for entry in poke_data:
            json.dump(entry, outfile)
            outfile.write('\n')


def write_to_bigquery(project_id, file_path):
    client = bigquery.Client()
    table_id = '{}.input_data.pokemon_data_raw'.format(project_id)

    schema = [
        bigquery.SchemaField("json", "string", mode="NULLABLE"),
    ]

    table = bigquery.Table(table_id, schema=schema)

    try:
        client.get_table(table)
    except exceptions.NotFound:
        print('Table {} not found, creating...'.format(table))
        try:
            client.create_table(table)
        except exceptions.Conflict as e:
            print('Table {} already exists.'.format(table))
            raise e
        except Exception as e:
            print('Error creating table {}: {}'.format(table, e))
            raise e
    except Exception as e:
        print('Error getting table {}: {}'.format(table, e))
        raise e

    print('Writing data to table {}'.format(table))

    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        field_delimiter='ç',
        skip_leading_rows=1,
    )

    with open(file_path, 'rb') as source_file:
        job = client.load_table_from_file(source_file, table_id, job_config=job_config)

    job.result()


@click.command()
@click.option('-p', '--project-id', required=True, help='Google Cloud Project ID')
@click.option('-f', '--file-path', default='pokemon_data.json', help='Path to file to write to')
def main(file_path, project_id):
    if not os.path.isfile(file_path):
        data = get_data()
        write_to_disk(data, file_path)

    write_to_bigquery(project_id, file_path)


if __name__ == '__main__':
    main()
