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
import javafx.stage.FileChooser;
import javafx.stage.Stage;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
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

        TextField dbportTextField = new TextField();
        grid.add(dbportTextField, 1, 4);
        pane.setCenter(label);

        Label dbname = new Label("DB name:");
        grid.add(dbname, 0, 5);

        TextField dbNameTextField = new TextField();
        grid.add(dbNameTextField, 1, 5);
        pane.setCenter(label);

        FileChooser fileChooser = new FileChooser();
        Label pg_dumpLoc= new Label("pg_dump localization:");
        grid.add(pg_dumpLoc, 0, 6);

        final String[] pg_dumpLocation = new String[1];
        pg_dumpLocation[0] = "";
        Button pg_dumpLocTextField = new Button("Select pg_dump location");
        pg_dumpLocTextField.setOnAction(e -> {
            File selectedFile = fileChooser.showOpenDialog(stage);
            pg_dumpLocation[0] = selectedFile.getAbsolutePath();
        });
        grid.add(pg_dumpLocTextField, 1, 6);
        pane.setCenter(label);

        Label backupLoc= new Label("Backup localization:");
        grid.add(backupLoc, 0, 7);

        TextField backupLocTextField = new TextField();
        grid.add(backupLocTextField, 1, 7);
        pane.setCenter(label);


        Label hostmaster = new Label("Hostmaster:");
        grid.add(hostmaster, 0, 8);

        TextField hostmasterTextField = new TextField();
        grid.add(hostmasterTextField, 1, 8);
        pane.setCenter(label);


        Label primaryNameserver = new Label("Primary nameserver:");
        grid.add(primaryNameserver, 0, 9);

        TextField primaryNameserverTextField = new TextField();
        grid.add(primaryNameserverTextField, 1, 9);
        pane.setCenter(label);


        Label secondaryNameserver = new Label("Secondary nameserver:");
        grid.add(secondaryNameserver, 0, 10);

        TextField secondaryNameserverTextField = new TextField();
        grid.add(secondaryNameserverTextField, 1, 10);
        pane.setCenter(label);


        Button btn = new Button("Sign in");
        HBox hbBtn = new HBox(10);
        hbBtn.setAlignment(Pos.BOTTOM_RIGHT);
        hbBtn.getChildren().add(btn);
        grid.add(hbBtn, 1, 11);
        Text dbConnectionError = new Text();
        dbConnectionError.setText("There was an error while connecting to database");
        Text requiredFieldsError = new Text();
        requiredFieldsError.setText("Hostmaster and nameservers are required");

        btn.setOnAction(e -> {
            grid.getChildren().removeIf(node -> GridPane.getRowIndex(node) == 12 || GridPane.getRowIndex(node) == 13);
            dbConfig.setUsername(userTextField.getText());
            dbConfig.setPassword(pwBox.getText());
            dbConfig.setDbPort(dbportTextField.getText());
            dbConfig.setDbName(dbNameTextField.getText());
            dbConfig.setHostname(hostnameTextField.getText());
            dbConfig.setPg_dumpLocalization(pg_dumpLocation[0]);
            dbConfig.setBackupLocalization(backupLocTextField.getText());
            dbConfig.setHostmaster(hostmasterTextField.getText());
            dbConfig.setPrimaryNameserver(primaryNameserverTextField.getText());
            dbConfig.setSecondaryNameserver(secondaryNameserverTextField.getText());
            try {
                if (hostmasterTextField.getText().isEmpty() || primaryNameserverTextField.getText().isEmpty()
                        || secondaryNameserverTextField.getText().isEmpty())
                {
                    grid.add(requiredFieldsError, 1, 12);
                    testDbConnection();
                }
                else
                {
                    testDbConnection();
                    stage.close();
                }
            } catch (SQLException e1) {

                grid.add(dbConnectionError, 1, 13);
                e1.printStackTrace();
            }
        });

        Scene scene = new Scene(grid, 800, 600);
        stage.setScene(scene);

        stage.show();
    }

    public void testDbConnection() throws SQLException {
        synchronized (this){
            Connection conn = DriverManager.getConnection("jdbc:postgresql://" + dbConfig.getHostname() + ":" + dbConfig.getDbPort() + "/" + dbConfig.getDbName()
                    , dbConfig.getUsername()
                    , dbConfig.getPassword());
            conn.isClosed();
        }
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