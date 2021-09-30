#!/bin/bash
man bash | grep -o "[[:alpha:]]\{4,\}" | sort | uniq -i -c | sort -rnk1 | head -3
