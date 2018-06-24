import multiprocessing

from settings import HOSTNAME, PORT

workers = multiprocessing.cpu_count()

bind = f'{HOSTNAME}:{PORT}'

accesslog = '-'

errorlog = '-'
