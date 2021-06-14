# The script assumes that the user is in the stim-tutorial repository
cd ..

# Clone the repository locally
git clone https://github.com/PreibischLab/imglib2-st

# Install STIM
cd imglib2-st
./install $HOME/bin

# Go back to the stim-tutorial folder that contains the example datasets
cd ../stim-tutorial/datasets

# Run the command that creates the container and normalizes the data
st-resave \
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
  -o='slideseq_mouse_brain.n5'

# Once the container is created, run the command that aligns the sections in 3D
# First align the pairs
st-align-pairs \
  -i slideseq_mouse_brain.n5 \
  -d 'Puck_180528_20,Puck_180528_22,Puck_180531_13,Puck_180531_17,Puck_180531_18,Puck_180531_19,Puck_180531_22,Puck_180531_23,Puck_180602_15,Puck_180602_16,Puck_180602_17,Puck_180602_18,Puck_180602_20'

# Second align the whole stack with ICP
st-align-global \
  -i 'slideseq_mouse_brain.n5'

# Save a few genes on disk to see if alignment worked
mkdir exportdir
st-render \
     -i 'slideseq_mouse_brain.n5' \
     -g 'Calm2,Hpca,Ptgds' \
     -o 'exportdir'

# Explore the data using BigDataViewer
st-bdv-view \
     -i 'slideseq_mouse_brain.n5' \
     -g 'Calm2,Hpca' \
     -md 'celltype' \
     -sf 0.5