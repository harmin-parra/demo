package karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import io.qameta.allure.karate.AllureKarate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class TestRunner {

    @Karate.Test
    public Karate allTests() {
        return Karate
                .run("classpath:rest_api_karate", "classpath:web_karate")
                .hook(new AllureKarate())
                .relativeTo(getClass())
                .outputJunitXml(true);
    }

    @Test
    public void folderTests() {
        // Results results = Runner.path("classpath:" + getClass().getPackageName().replace('.', '/'))
        Results results = Runner.path("classpath:web_karate/form_page")
                .outputCucumberJson(true)
                .outputJunitXml(true)
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void modularityTests() {
        // Results results = Runner.path("classpath:" + getClass().getPackageName().replace('.', '/'))
        Results results = Runner.path("classpath:karate/modularity")
                .outputCucumberJson(true)
                .outputJunitXml(true)
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
