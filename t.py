#!/opt/local/bin/python2.7
# -*- coding: utf-8 -*-
import sys
sys.path+=['.']
import wordseg
s=wordseg.wordseg()
s.load_dict("data/dict.txt")
for l in open("data/p.txt"):
	l=l.strip()
	if len(l)>0:
		b=s.segment(l,1,0)
		print l
		for i in b:
			print i
