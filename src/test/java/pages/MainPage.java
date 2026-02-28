package pages;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.By;

public class MainPage extends BasePage {

    // Locators based on typical Minimal-Todo app identifiers (can be adjusted later if needed)
    private final By addToDoButton = AppiumBy.id("com.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB");
    private final By emptyStateContainer = AppiumBy.id("com.avjindersinghsekhon.minimaltodo:id/toDoEmptyView");
    private final By toDoListContainer = AppiumBy.id("com.avjindersinghsekhon.minimaltodo:id/toDoRecyclerView");
    
    public MainPage(AndroidDriver driver) {
        super(driver);
    }

    public AddToDoPage clickAddToDo() {
        click(addToDoButton);
        return new AddToDoPage(driver);
    }

    public boolean isEmptyStateVisible() {
        return isElementDisplayed(emptyStateContainer);
    }

    public boolean isToDoListVisible() {
        return isElementDisplayed(toDoListContainer);
    }
    
    public boolean isTaskPresent(String taskText) {
        By taskLocator = AppiumBy.xpath("//android.widget.TextView[@text='" + taskText + "']");
        return isElementDisplayed(taskLocator);
    }
}
