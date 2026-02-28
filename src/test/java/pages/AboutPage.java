package pages;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;

public class AboutPage extends BasePage {

    // Usually there's an app version text view or developer info
    private final By appVersionText = AppiumBy.id("com.avjindersinghsekhon.minimaltodo:id/appVersionTextView");
    private final By backButton = AppiumBy.accessibilityId("Navigate up");

    public AboutPage(AndroidDriver driver) {
        super(driver);
    }

    public boolean isAppVersionVisible() {
        return isElementDisplayed(appVersionText);
    }

    public MainPage goBack() {
        click(backButton);
        return new MainPage(driver);
    }
}
