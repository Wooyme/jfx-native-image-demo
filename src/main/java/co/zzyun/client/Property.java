package co.zzyun.client;

public class Property{
  private String host;
  private int port;
  private String username;
  private String password;

  public Property(String host,int port,String username,String password){
    this.host = host;
    this.port = port;
    this.username = username;
    this.password = password;
  }

  public String getHost() {
    return host;
  }

  public void setHost(String host) {
    this.host = host;
  }

  public int getPort() {
    return port;
  }

  public void setPort(int port) {
    this.port = port;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  @Override
  public String toString(){
    return this.host+":"+this.port;
  }

  public String toLocalString(){
    return this.host+":"+this.port+":"+this.username+":"+this.password;
  }

  public static Property fromLocalString(String line){
    int hostEnd = line.indexOf(":");
    int portEnd = line.indexOf(":",hostEnd+1);
    int userEnd = line.indexOf(":",portEnd+1);
    String host = line.substring(0,hostEnd);
    int port = Integer.valueOf(line.substring(hostEnd+1,portEnd));
    String user = line.substring(portEnd+1,userEnd);
    String pass = line.substring(userEnd+1);
    return new Property(host,port,user,pass);
  }

}
