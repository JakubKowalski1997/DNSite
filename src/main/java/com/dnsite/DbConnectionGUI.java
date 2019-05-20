package com.dnsite;

import com.dnsite.utils.hibernate.DbConfig;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.util.concurrent.CountDownLatch;

public class DbConnectionGUI extends Application {
    private DbConfig dbConfig;
    public static final CountDownLatch latch = new CountDownLatch(1);
    public static DbConnectionGUI dbConnectionGUI = null;

    public static DbConnectionGUI waitForStartUpTest() {
        try {
            latch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return dbConnectionGUI;
    }

    public static void setDbConnectionGUI(DbConnectionGUI dbConnectionGUI0) {
        dbConnectionGUI = dbConnectionGUI0;
        latch.countDown();
    }

    public DbConnectionGUI() {
        setDbConnectionGUI(this);
    }

    public void printSomething() {
        System.out.println("You called a method on the application");
    }

    @Override
    public void start(Stage stage) throws Exception {
        dbConfig = new DbConfig();
        BorderPane pane = new BorderPane();

        Label label = new Label("Hello");
        GridPane grid = new GridPane();
        grid.setAlignment(Pos.CENTER);
        grid.setHgap(10);
        grid.setVgap(10);
        grid.setPadding(new Insets(25, 25, 25, 25));
        Text scenetitle = new Text("Welcome");
        scenetitle.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
        grid.add(scenetitle, 0, 0, 2, 1);

        Label userName = new Label("User Name:");
        grid.add(userName, 0, 1);

        TextField userTextField = new TextField();
        grid.add(userTextField, 1, 1);

        Label pw = new Label("Password:");
        grid.add(pw, 0, 2);

        PasswordField pwBox = new PasswordField();
        grid.add(pwBox, 1, 2);

        Label hostname = new Label("Hostname:");
        grid.add(hostname, 0, 3);

        TextField hostnameTextField = new TextField();
        grid.add(hostnameTextField, 1, 3);

        Label dbport = new Label("DB port:");
        grid.add(dbport, 0, 4);

        PasswordField dbportTextField = new PasswordField();
        grid.add(dbportTextField, 1, 4);
        pane.setCenter(label);

        Button btn = new Button("Sign in");
        HBox hbBtn = new HBox(10);
        hbBtn.setAlignment(Pos.BOTTOM_RIGHT);
        hbBtn.getChildren().add(btn);
        grid.add(hbBtn, 1, 5);

        btn.setOnAction(e -> {
            dbConfig.setUsername(userTextField.getText());
            dbConfig.setPassword(pwBox.getText());
            stage.close();
            //test connection
        });

        Scene scene = new Scene(grid, 300, 275);
        stage.setScene(scene);

        stage.show();
    }

    public DbConfig getDbConfig() {
        return dbConfig;
    }

    public void setDbConfig(DbConfig dbConfig) {
        this.dbConfig = dbConfig;
    }

    public static void main(String[] args) {
        Application.launch(args);
    }
}