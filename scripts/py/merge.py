import csv
import sys
writer = csv.DictWriter(open('merged.csv', 'w'), fieldnames=['from', 'gas', 'to', 'value', 'input', 'status'])
writer.writeheader()
for i in range(int(sys.argv[1])):
    with open('out' + str(i) + '.csv') as f:
        reader = csv.DictReader(f)
        for line in reader:
            writer.writerow(line)
