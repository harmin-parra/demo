package starter.actions;

import net.serenitybdd.annotations.Step;
import net.serenitybdd.core.steps.UIInteractionSteps;
import starter.pageobjects.WebForm;

public class WebFormSteps extends UIInteractionSteps {

    WebForm webform;

    @Step("Open the webform page")
    public void openPage() {
        webform.openPage();
    }

    @Step("Complete webform")
    public void fill(String var0, String var1, String var2, int var3, String var4, String var5, String var6, String var7, int var8) {
        webform.setLogin(var0);
        webform.setPassword(var1);
        webform.setTextarea(var2);
        webform.setNumber(var3);
        webform.setCity(var4);
        webform.setFile(var5);
        webform.setColor(var6);
        webform.setDate(var7);
        webform.setRange(var8);
    }

    @Step("Submit webform")
    public void submit() {
        webform.submit();
        webform.verify_submit();
    }

}
