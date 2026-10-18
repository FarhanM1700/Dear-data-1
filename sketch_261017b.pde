Table myData; // Variable to hold the CSV data

void setup() {
  size(800, 600); // Set your window size
  background(255); // White background

  // Load the CSV file from the data folder
  // The header() function tells Processing the first row contains column names
  myData = loadTable("distraction_data.csv", "header"); 

  // Check if the file loaded successfully
  if (myData == null) {
    println("ERROR: Could not load the CSV file. Check the file name and location.");
    return;
  }

  // --- Example of how to read and display the data ---
  
  println("Total rows in CSV: " + myData.getRowCount());
  println("Total columns in CSV: " + myData.getColumnCount());

  // Let's assume your CSV has a column named "Value" (change this to match your actual column name)
  // If you don't know the column names, you can use myData.getColumnTitle(0) for the first column.
  
  fill(0); // Text color black
  textSize(16);
  textAlign(LEFT, TOP);
  text("CSV Data Loaded Successfully!", 20, 20);

  // Loop through the rows and print them to the screen
  for (int i = 0; i < myData.getRowCount(); i++) {
    // Get the data from the first column (index 0)
    // Change 0 to 1 for the second column, etc.
    String col1Data = myData.getString(i, 0); 
    
    // Get the data from the second column (index 1) - assuming it's a number
    // If it's text, use getString instead of getFloat
    float col2Data = myData.getFloat(i, 1); 

    // Display the text on the screen
    // i * 30 spaces the text out vertically
    text("Row " + i + ": Col 1 = " + col1Data + " | Col 2 = " + col2Data, 20, 60 + (i * 30));
  }
}

void draw() {
  // We don't need draw() for this simple display, 
  // but it's here if you want to animate things later.
}
