import numpy as np

# Grab filename from command line
import sys
filename = sys.argv[1]

# Load data
data = np.loadtxt(filename)

v_to_mmHg = 71.2

# Multiply all values in data by scalar
data = data * v_to_mmHg
