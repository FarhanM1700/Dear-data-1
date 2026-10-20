Table myData; // Variable to hold the CSV data

void setup() {
  size(1000, 800); // I made the window a bit wider and taller to fit the new text and more rows
  background(255); 

  // Load the CSV file
  myData = loadTable("distraction_data.csv", "header"); 

  // Check if the file loaded successfully
  if (myData == null) {
    println("ERROR: Could not load the CSV file.");
    return;
  }

  println("CSV Loaded! Total rows: " + myData.getRowCount());
  
  // Call our custom method to get the total time
  int totalMins = calculateTotalTime(myData);
  println("Total distraction time: " + totalMins + " minutes");
}

void draw() {
  background(255); // Clear screen every frame
  
  fill(0);
  textSize(18);
  textAlign(LEFT, TOP);
  text("Total Distraction Time: " + calculateTotalTime(myData) + " mins", 20, 20);
  
  // Start drawing our data further down the screen
  int startY = 80; 

  // Loop through the rows to draw the data
  for (int i = 0; i < myData.getRowCount(); i++) {
    
    // --- UPDATED INDEXES DUE TO NEW DATE COLUMN ---
    String date = myData.getString(i, 0);      // NEW: Date is now index 0
    String time = myData.getString(i, 1);      // Shifted from 0 to 1
    String app = myData.getString(i, 2);       // Shifted from 1 to 2
    int duration = myData.getInt(i, 3);        // Shifted from 2 to 3
    String trigger = myData.getString(i, 4);   // Shifted from 3 to 4

    // 2. Determine Color based on Trigger (Creative choice!)
    color circleColor;
    if (trigger.equals("Notification")) {
      circleColor = color(0, 150, 255); // Blue
    } else if (trigger.equals("Boredom")) {
      circleColor = color(255, 100, 0); // Orange
    } else if (trigger.equals("Habit")) {
      circleColor = color(200, 0, 200); // Purple
    } else {
      circleColor = color(100); // Grey for anything else (like "Purpose")
    }
    
    // 3. Draw the visualization
    fill(circleColor);
    noStroke();
    
    // X position is fixed for now, Y position moves down per row
    float xPos = 150; 
    // I changed the spacing from 50 to 45 so more rows fit on the screen
    float yPos = startY + (i * 45); 
    
    // Circle size is based on duration (multiplied by 5 to make it visible)
    float circleSize = duration * 5; 
    
    ellipse(xPos, yPos, circleSize, circleSize);
    
    // 4. Add text labels next to the circles
    fill(0);
    textSize(14); // Made text slightly smaller to fit
    textAlign(LEFT, CENTER);
    // Added the date to the text string
    text(date + " | " + time + " | " + app + " (" + duration + "m) - " + trigger, xPos + 40, yPos);
  }
}

// --- CUSTOM METHOD ---
// fulfilling the rubric requirement: "write a short method that returns a value"
int calculateTotalTime(Table data) {
  int total = 0;
  
  // Loop through all rows and add up the duration (column index is now 3)
  for (int i = 0; i < data.getRowCount(); i++) {
    total += data.getInt(i, 3); // Changed from 2 to 3
  }
  
  return total;
}
