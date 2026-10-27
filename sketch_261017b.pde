
Table myData; // Variable to hold the CSV data

void setup() {
  //   fit 25 rows 
  size(1000, 1200); 
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
    
    String date = myData.getString(i, 0);      
    String time = myData.getString(i, 1);      
    String app = myData.getString(i, 2);       
    int duration = myData.getInt(i, 3);        
    String trigger = myData.getString(i, 4);   

    // Determine Color based on Trigger
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
    
    // Draw the visualization
    fill(circleColor);
    noStroke();
    
    float xPos = 150; 
    
    float yPos = startY + (i * 40); 
    
    
    float circleSize = duration * 5; 
    
    ellipse(xPos, yPos, circleSize, circleSize);
    
    // Add text labels next to the circles
    fill(0);
    textSize(14); 
    textAlign(LEFT, CENTER);
    text(date + " | " + time + " | " + app + " (" + duration + "m) - " + trigger, xPos + 40, yPos);
  }
}

// --- Custom method which returns value ---
int calculateTotalTime(Table data) {
  int total = 0; // init total
  
  for (int i = 0; i < data.getRowCount(); i++) { // for loop
    total += data.getInt(i, 3);  // takes index (i) and column index(3) and increments each time
  }
  
  return total; // returns total
}
