package co.zzyun.client;

import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Paths;
public class UIController {
  @FXML
  public Label statusLabel;
  @FXML
  private ListView<Property> listView;
  @FXML
  private TextField remoteAddressTextField;
  @FXML
  private TextField remotePortTextField;
  @FXML
  private TextField usernameTextField;
  @FXML
  private TextField passwordTextField;

  private Number selected = -1;

  @FXML
  protected void initialize() {
    loadFromFile();
    listView.getSelectionModel()
      .selectedIndexProperty().addListener((observable, oldValue, newValue) -> {
      if (newValue.intValue() < 0) return;
      this.selected = newValue;
      setProperty();
    });
  }
  @FXML
  protected void onAddButtonClicked(ActionEvent event) {
    String host = remoteAddressTextField.getText();
    Integer remotePort = new Integer(remotePortTextField.getText());
    String username = usernameTextField.getText();
    String password = passwordTextField.getText();
    listView.getItems().add(new Property(host,remotePort,username,password));
    this.selected = listView.getItems().size()-1;
    saveToFile();
  }

  public void onRemoveButtonClicked(ActionEvent actionEvent) {
    if(this.selected.intValue()<0) return;
    listView.getItems().remove(this.selected.intValue());
    if(listView.getItems().size()==0) this.selected = -1;
    else{
      this.selected = 0;
      this.listView.getSelectionModel().select(this.selected.intValue());
    }
    setProperty();
    saveToFile();
  }

  private void setProperty() {
    Property property;
    try {
      property = this.listView.getItems().get(this.selected.intValue());
    }catch (Throwable e){
      remoteAddressTextField.clear();
      remotePortTextField.clear();
      usernameTextField.clear();
      passwordTextField.clear();
      return;
    }
    remoteAddressTextField.setText(property.getHost());
    remotePortTextField.setText(String.valueOf(property.getPort()));
    usernameTextField.setText(property.getUsername());
    passwordTextField.setText(property.getPassword());
  }

  private void saveToFile(){
    File file = new File(Paths.get(System.getProperty("user.dir"),"save.cfg").toString());
    try {
      BufferedWriter writer = new BufferedWriter(new FileWriter(file));
      StringBuilder sb = new StringBuilder();
      this.listView.getItems().forEach(v-> sb.append(v.toLocalString()).append("\n"));
      writer.write(sb.toString());
      writer.close();
    } catch (IOException e) {
      
    }
  }

  private void loadFromFile(){
    File file = new File(Paths.get(System.getProperty("user.dir"),"save.cfg").toString());
    try{
      BufferedReader reader = new BufferedReader(new FileReader(file));
      String line;
      while((line=reader.readLine())!=null){
        this.listView.getItems().add(Property.fromLocalString(line));
      }
      reader.close();
    }catch (IOException e){
      
    }
  }

  public void onConfirmButtonClicked(ActionEvent actionEvent) {
    String host = remoteAddressTextField.getText();
    Integer remotePort = new Integer(remotePortTextField.getText());
    String username = usernameTextField.getText();
    String password = passwordTextField.getText();
    statusLabel.setText("正在连接...");
    new Thread(()->{
       Platform.runLater(()->{
         statusLabel.setText("连接成功");
       });
    }).start();

  }
}
