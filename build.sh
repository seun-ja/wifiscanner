# Paths
OUTPUT_DIR="./macros/output"
SRC_FILE=./macros/scan.mm
OUTPUT_BINARY="./macros/output/wifiscanner"

# Check if build directory exists, if not, create it
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir "$OUTPUT_DIR"
fi

clang++ "$SRC_FILE" \
  -framework CoreWLAN \
  -framework Foundation \
  -o "$OUTPUT_BINARY"

# Check if compilation was successful
if [ $? -eq 0 ]; then
  echo "Compilation successful."
  echo "Running the program..."
  # Run the compiled binary
  "$OUTPUT_BINARY"
else
  echo "Compilation failed."
fi
