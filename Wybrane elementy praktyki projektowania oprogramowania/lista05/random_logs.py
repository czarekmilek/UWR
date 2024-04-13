import random
import time

def generate_log_line(ip):
    method = ['GET', 'POST', 'PUT', 'DELETE']
    resources = ['/page1', '/page2', '/api/resource', '/static/image.jpg', '/login']
    status = [200, 404, 500]

    timestamp = time.strftime('%H:%M:%S')
    method = random.choice(method)
    resource = random.choice(resources)
    status = random.choice(status)

    log_line = f'{timestamp} {ip} {method} {resource} {status}\n'
    return log_line

def generate_logs(file_path, num_lines):
    ips = ['192.168.0.1', '192.168.0.2', '192.168.0.3', '192.168.0.4', '192.168.0.5']

    with open(file_path, 'w') as file:
        for _ in range(num_lines):
            ip = random.choice(ips)
            log_line = generate_log_line(ip)
            file.write(log_line)


log_file_path = 'przykladowe_logi.txt'
num_lines = 1000

generate_logs(log_file_path, num_lines)
