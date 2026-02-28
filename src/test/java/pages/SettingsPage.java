package pages;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;

public class SettingsPage extends BasePage {

    private final By themeSwitch = AppiumBy.id("com.avjindersinghsekhon.minimaltodo:id/switchWidget");
    private final By backButton = AppiumBy.accessibilityId("Navigate up");

    public SettingsPage(AndroidDriver driver) {
        super(driver);
    }

    public SettingsPage toggleNightMode() {
        click(themeSwitch);
        return this;
    }

    public boolean isNightModeSwitchVisible() {
        return isElementDisplayed(themeSwitch);
    }
    
    public MainPage goBack() {
        click(backButton);
        return new MainPage(driver);
    }
}
