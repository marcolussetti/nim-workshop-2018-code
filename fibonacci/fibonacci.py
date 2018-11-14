#!/usr/bin/python3
import argparse


def fib(n):
    if n <= 1:
        return 1
    return fib(n - 1) + fib(n - 2)


parser = argparse.ArgumentParser(description="Nth Fibonacci")
parser.add_argument("--nth", type=int)
args = parser.parse_args()

print(fib(args.nth if args.nth else input("Enter Nth Fibonacci to compute: ")))
