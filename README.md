# stim-tutorial
This repository contains a tutorial on how to install and successfully run
the [STIM](https://github.com/PreibischLab/imglib2-st) library and exploit imaging
techniques to analyze spatial transcriptomics datasets.

## Installation
To install `STIM`, run the following commands:

```
cd ..
git clone https://github.com/PreibischLab/imglib2-st
cd imglib2-st
./install $HOME/bin
cd ../stim-tutorial/datasets
```

## Usage

### Creating the project container

After installing `STIM`, run the following command to create the container
from the 14 SlideSeqV2 spatial transcriptomics datasets

```st-resave \
  -i='Puck_180528_20/BeadLocationsForR.csv.gz,Puck_180528_20/MappedDGEForR.csv.gz,Puck_180528_20/clusters.csv,Puck_180528_20' \
  -i='Puck_180528_22/BeadLocationsForR.csv.gz,Puck_180528_22/MappedDGEForR.csv.gz,Puck_180528_22/clusters.csv,Puck_180528_22' \
  -i='Puck_180531_13/BeadLocationsForR.csv.gz,Puck_180531_13/MappedDGEForR.csv.gz,Puck_180531_13/clusters.csv,Puck_180531_13' \
  -i='Puck_180531_17/BeadLocationsForR.csv.gz,Puck_180531_17/MappedDGEForR.csv.gz,Puck_180531_17/clusters.csv,Puck_180531_17' \
  -i='Puck_180531_18/BeadLocationsForR.csv.gz,Puck_180531_18/MappedDGEForR.csv.gz,Puck_180531_18/clusters.csv,Puck_180531_18' \
  -i='Puck_180531_19/BeadLocationsForR.csv.gz,Puck_180531_19/MappedDGEForR.csv.gz,Puck_180531_19/clusters.csv,Puck_180531_19' \
  -i='Puck_180531_22/BeadLocationsForR.csv.gz,Puck_180531_22/MappedDGEForR.csv.gz,Puck_180531_22/clusters.csv,Puck_180531_22' \
  -i='Puck_180531_23/BeadLocationsForR.csv.gz,Puck_180531_23/MappedDGEForR.csv.gz,Puck_180531_23/clusters.csv,Puck_180531_23' \
  -i='Puck_180602_15/BeadLocationsForR.csv.gz,Puck_180602_15/MappedDGEForR.csv.gz,Puck_180602_15/clusters.csv,Puck_180602_15' \
  -i='Puck_180602_16/BeadLocationsForR.csv.gz,Puck_180602_16/MappedDGEForR.csv.gz,Puck_180602_16/clusters.csv,Puck_180602_16' \
  -i='Puck_180602_17/BeadLocationsForR.csv.gz,Puck_180602_17/MappedDGEForR.csv.gz,Puck_180602_17/clusters.csv,Puck_180602_17' \
  -i='Puck_180602_18/BeadLocationsForR.csv.gz,Puck_180602_18/MappedDGEForR.csv.gz,Puck_180602_18/clusters.csv,Puck_180602_18' \
  -i='Puck_180602_20/BeadLocationsForR.csv.gz,Puck_180602_20/MappedDGEForR.csv.gz,Puck_180602_20/clusters.csv,Puck_180602_20' \
  -n \
  -o='slideseq_mouse_brain.n5'_180602_15/clusters.csv,Puck_180602_15' \
  -i='Puck_180602_16/BeadLocationsForR.csv.gz,Puck_180602_16/MappedDGEForR.csv.gz,Puck_180602_16/clusters.csv,Puck_180602_16' \
  -i='Puck_180602_17/BeadLocationsForR.csv.gz,Puck_180602_17/MappedDGEForR.csv.gz,Puck_180602_17/clusters.csv,Puck_180602_17' \
  -i='Puck_180602_18/BeadLocationsForR.csv.gz,Puck_180602_18/MappedDGEForR.csv.gz,Puck_180602_18/clusters.csv,Puck_180602_18' \
  -i='Puck_180602_20/BeadLocationsForR.csv.gz,Puck_180602_20/MappedDGEForR.csv.gz,Puck_180602_20/clusters.csv,Puck_180602_20' \
  -n \
  -o='slideseq_mouse_brain.n5'
```

### 3D alignment
Once the container is created, run the command that aligns the sections in 3D.
First, align all sections in a pairwise manner

```
st-align-pairs \
  -i slideseq_mouse_brain.n5 \
  -d 'Puck_180528_20,Puck_180528_22,Puck_180531_13,Puck_180531_17,Puck_180531_18,Puck_180531_19,Puck_180531_22,Puck_180531_23,Puck_180602_15,Puck_180602_16,Puck_180602_17,Puck_180602_18,Puck_180602_20'
```

```
st-align-pairs \
  -i slideseq_mouse_brain.n5 \
  -d 'Puck_180528_20,Puck_180528_22,Puck_180531_13,Puck_180531_17,Puck_180531_18,Puck_180531_19,Puck_180531_22,Puck_180531_23,Puck_180602_15,Puck_180602_16,Puck_180602_17,Puck_180602_18,Puck_180602_20'
```

Then, align the whole stack with ICP

```
st-align-global -i 'slideseq_mouse_brain.n5'
```

### Visualization
Save a few genes on disk to verify that alignment worked

```
mkdir exportdir
st-render \
  -i 'slideseq_mouse_brain.n5' \
  -g 'Calm2,Hpca,Ptgds' \
  -o 'exportdir'
```

Explore the data using the `BigDataViewer`

```
st-bdv-view \
  -i 'slideseq_mouse_brain.n5' \
  -g 'Calm2,Hpca' \
  -md 'celltype' \
  -sf 0.5
```

## Downstream analysis with python
All analyses performed by STIM are stored in the `n5` container of the project.
To facilitate downstream analysis and integration with other tools we developed 
[stimwrap](https://github.com/nukappa/stimwrap), a Python wrapper that enables
the intuitive extraction of information from the `n5` container within Python.

`stimwrap` can be installed directly with pip

```
pip install stimwrap
```

