from settings import HOSTNAME, PORT

workers = 1

threads = 2

bind = f'{HOSTNAME}:{PORT}'

accesslog = '-'

errorlog = '-'
