package pages;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;

public class AddToDoPage extends BasePage {

    private final By titleInput = AppiumBy.id("com.avjindersinghsekhon.minimaltodo:id/userToDoEditText");
    private final By makeToDoButton = AppiumBy.id("com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton");
    
    public AddToDoPage(AndroidDriver driver) {
        super(driver);
    }

    public AddToDoPage enterTitle(String title) {
        type(titleInput, title);
        return this;
    }

    public MainPage saveToDo() {
        click(makeToDoButton);
        return new MainPage(driver);
    }
}
