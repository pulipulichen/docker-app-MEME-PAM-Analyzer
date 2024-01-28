#!/bin/bash

jupyter nbconvert --to html --execute index.ipynb
rm index.html