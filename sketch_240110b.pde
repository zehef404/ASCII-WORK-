import processing.video.*;
PImage[] customPixels = new PImage[10]; // Tableau pour stocker les 10 pixels personnalisés
float scaleFactor = 0.5; // Facteur d'échelle
Capture video;

void setup() {
  size(980, 800);
  
  // Initialise la capture vidéo depuis la webcam
  String[] cameras = Capture.list();
  if (cameras.length > 0) {
    video = new Capture(this, cameras[0]);
    video.start();
   
  } else {
    println("Aucune webcam trouvée.");
  }
  
  // Chargez vos 10 pixels personnalisés depuis le répertoire du sketch
  for (int i = 0; i < 10; i++) {
    customPixels[i] = loadImage("pixel_" + (i + 1) + ".png"); // Remplacez "pixel_" par le préfixe de vos fichiers et ".png" par l'extension
    // Redimensionnez vos customPixels en fonction du scale factor
    customPixels[i].resize(int(customPixels[i].width * scaleFactor), int(customPixels[i].height * scaleFactor));
  }
}

void draw() {
 background(5,108,106);
//  background(199,105,12);
  if (video.available()) {
    video.read();
    
    // Parcourez tous les pixels de l'image
    video.loadPixels();
    for (int i = 0; i < video.pixels.length; i++) {
      // Obtenez la couleur du pixel
      color pixelColor = video.pixels[i];
      
      // Calculez la luminosité du pixel
      float brightnessValue = brightness(pixelColor);
      
      // Normalisez la luminosité pour obtenir un index entre 1 et 10
      int brightnessIndex = int(map(brightnessValue,300, mouseX*3, 10, mouseY/7));
      
      // Assurez-vous que l'index reste dans les limites du tableau
      brightnessIndex = constrain(brightnessIndex, 1, 10);
      
      // Utilisez l'index pour obtenir le pixel personnalisé correspondant
      PImage customPixel = customPixels[brightnessIndex - 1];
      
      // Dessinez le pixel personnalisé à la position correspondante
      int x = i % video.width*3;
      int y = i / video.height*3;
   //   image(customPixel, x * height, y * width);
  // image(customPixel, x / scaleFactor, y / scaleFactor);  
    image(customPixel, x * scaleFactor, y * scaleFactor);  
  }
  } //blendMode(DIFFERENCE);
}
