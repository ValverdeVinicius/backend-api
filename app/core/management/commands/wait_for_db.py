"""
Comando Django para esperar a inicialização do banco de dados
"""
import time

from psycopg2 import OperationalError as Psycopg2OpError

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """ Comando do Django para esperar pelo banco de dados"""

    def handle(self, *args, **options):
        """ Ponto de entrada para o comando"""
        self.stdout.write
        ('Esperando pelo Banco de Dados...')
        db_up = False
        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up = True
            except(Psycopg2OpError, OperationalError):
                self.stdout.write
                ('Banco de dados indisponível, espere 1 segundo...')
                time.sleep(1)      
        self.stdout.write(self.style.SUCCESS('Banco de Dados Disponível!'))
