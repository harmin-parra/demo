package examples;

import io.qameta.allure.Allure;
import org.junit.jupiter.api.Test;

public class MetadataTest {

    @Test
    public void method_name() {
        Allure.getLifecycle().updateTestCase(tr -> tr.getLabels().removeIf(label -> "suite".equals(label.getName())));
    	Allure.epic("Epic");
    	Allure.feature("Feature");
    	Allure.story("Story");
    	Allure.suite("Suite");
    }

}
