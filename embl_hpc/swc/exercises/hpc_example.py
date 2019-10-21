#!/usr/bin/python
'''
hpc_example.py -t <wait time> -l <list length>
'''

from getopt import getopt, GetoptError
from sys import argv, exit
from psutil import Process
from os import getpid
from time import sleep
from platform import node

def main(argv):
   wait_time = 10
   list_length = 0
   usage = 'hpc_example.py -t <wait time> -l <list length>'

   ## handle the arguments
   try:
      opts, args = getopt(argv,"ht:l:",["time=","length="])
   except GetoptError as err:
      print(err)
      print('hpc_example.py -t <wait time> -l <list length>')
      exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print('hpc_example.py -t <wait time> -l <list length>')
         exit()
      elif opt in ("-t", "--time"):
         wait_time = max(10, float(arg))
      elif opt in ("-l", "--length"):
         list_length = max(0, int(arg))

   print(f'Current host is: {node()}')
   print(f'Wait time is: {wait_time} seconds')
   print(f'List length is: {list_length}')

   ## create a list of the required length
   memory_use_list = list(range(list_length))
   process = Process(getpid())
   memory_used_MB = process.memory_info().rss / 1_000_000

   ## print the maximum memory usage to the screen
   print(f'Memory usage: {memory_used_MB} MB')

   ## wait for the specified number of seconds
   sleep(wait_time)

if __name__ == "__main__":
   main(argv[1:])
