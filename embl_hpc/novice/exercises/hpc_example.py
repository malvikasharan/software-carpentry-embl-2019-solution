#!/usr/bin/python

import sys, getopt, resource, time, platform

def main(argv):
   wait_time = 10
   list_length = 0

   ## handle the arguments
   try:
      opts, args = getopt.getopt(argv,"ht:l:",["time=","length="])
   except getopt.GetoptError as err:
      print str(err)
      print 'python_example.py -t <wait time> -l <list length>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'python_example.py -t <wait time> -l <list length>'
         sys.exit()
      elif opt in ("-t", "--time"):
         wait_time = max(10, float(arg) );
      elif opt in ("-l", "--length"):
         list_length = max(0, int(arg) )

   print 'Current host is:', platform.node()
   print 'Wait time is:', wait_time, 'seconds'
   print 'List length is:', list_length

   ## create a list of the required length
   list = []
   for i in range(0, list_length ):
     list.append(1)

   ## wait for the specified number of seconds
   time.sleep( wait_time )

   ## print the maximum memory usage to the screen
   print 'Memory usage:', resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1000.0, 'MB'

if __name__ == "__main__":
   main(sys.argv[1:])
