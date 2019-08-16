package co.zzyun.client;

import com.sun.glass.ui.Tray;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Paths;
import java.util.concurrent.atomic.AtomicBoolean;

public class UI extends Application {
  public static Tray tray;
  private static Process process;
  public static void main(String[] args) {
    //System.setProperty("prism.order","sw");
    //System.setProperty("prism.text","t2k");
    System.setProperty("prism.nativepisces","false");
    System.setProperty("prism.allowhidpi","false");
    //System.setProperty("prism.vsync","false");
    launch(args);
  }

  @Override
  public void start(Stage primaryStage) {
    String pwd = System.getProperty("user.dir");
    /* Ignore the tray*/
    tray = new Tray(Paths.get(pwd,"icon.ico").toString(),false);
    tray.addMenu("Open", () -> Platform.runLater(primaryStage::show));
    final AtomicBoolean isPac = new AtomicBoolean(true);
    tray.addMenu("PAC mode",()->{
      if(isPac.get()) {
        tray.updateMenu(1, "Global mode");
        isPac.set(false);
      }else{
        tray.updateMenu(1, "Pac mode");
        isPac.set(true);
      }
    });
    tray.addMenu("Exit",()->{
       try{ process.destroyForcibly(); }catch(Throwable e){}
      System.exit(0);
    });
    //----------------------------------------------------------------
    Parent root;
    try {
      root = FXMLLoader.load(new File("ui.fxml").toURI().toURL());
    } catch (IOException e) {
      e.printStackTrace();
      return;
    }
    primaryStage.setTitle("Demo");
    Scene scene = new Scene(root, 660, 295);
    primaryStage.setScene(scene);
    Platform.setImplicitExit(false);
    primaryStage.setOnCloseRequest(event -> Platform.runLater(primaryStage::hide));
    primaryStage.show();
  }
}
