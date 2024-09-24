package starter.acceptancetests;

import net.serenitybdd.annotations.Steps;
import net.serenitybdd.junit5.SerenityJUnit5Extension;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import starter.actions.WebFormSteps;

@ExtendWith(SerenityJUnit5Extension.class)
class TestWebForm {

    @Steps
    WebFormSteps webform;

    @Test
    @DisplayName("Fill-in WebForm page")
    void fillInWebForm() {
        webform.openPage();
        webform.fill("login", "password", "My textarea", 2, "Los Angeles", "/tmp/test/file.xml", "#00ff00", "01/01/2024", 1);
        webform.submit();
    }
}
