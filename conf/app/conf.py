import multiprocessing

from settings import HOSTNAME, PORT

workers = multiprocessing.cpu_count()

threads = 2

bind = f'{HOSTNAME}:{PORt}'

accesslog = '-'

errorlog = '-'
