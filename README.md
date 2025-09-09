# Counter and RSA Example

## To activate pyenv

```
pyenv activate py38
```

## To setup cocotb (remove any older versions and install v1.6.2)
```
pip uninstall cocotb
pip install cocotb==1.6.2
```

## To compile and generate verilog from bsv

```
make  generate_verilog
```

## To simulate using bsim
```
make b_sim 
```

## To simulate using cocotb
```
pip install cocotb_coverage==1.1
make simulate 
```

## To clean all the build directories
```
make clean
```

## To clean CoCoTb builds
```
make clean_build
```
