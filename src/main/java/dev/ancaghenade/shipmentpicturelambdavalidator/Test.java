package dev.ancaghenade.shipmentpicturelambdavalidator;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class Test {

  public static void main(String[] args) throws IOException {

    BufferedImage bufferedImage = ImageIO.read(new File("/Users/anca/Workspace/code/shipment-list-demo/shipment-picture-lambda-validator/src/main/java/dev/ancaghenade/shipmentpicturelambdavalidator/cat.jpeg"));
    Image image = bufferedImage.getScaledInstance(300, 300, Image.SCALE_DEFAULT);
    ImageIO.createImageInputStream(image);
  }

}
