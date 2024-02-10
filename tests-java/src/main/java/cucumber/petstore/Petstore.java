package cucumber.petstore;

import io.qameta.allure.Allure;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.ClassicHttpRequest;
import org.apache.hc.core5.http.HttpEntity;
import org.apache.hc.core5.http.NameValuePair;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.http.io.entity.StringEntity;
import org.apache.hc.core5.http.io.support.ClassicRequestBuilder;
import org.apache.hc.core5.http.message.BasicNameValuePair;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Petstore {

    public Object[] get(int id) {
        Object[] result;
        Allure.addAttachment("Request", " GET https://petstore.swagger.io/v2/pet/" + String.valueOf(id));
        try (CloseableHttpClient httpclient = HttpClients.createDefault()) {
            ClassicHttpRequest httpGet = ClassicRequestBuilder
                    .get("https://petstore.swagger.io/v2/pet/" + String.valueOf(id))
                    .build();
            result = httpclient.execute(httpGet, response -> {
                Object[] array = new Object[2];
                array[0] = response.getCode();
                final HttpEntity entity = response.getEntity();
                if (entity != null) {
                    JSONParser parser = new JSONParser();
                    JSONObject json;
                    try {
                        String str = EntityUtils.toString(entity);
                        json = (JSONObject) parser.parse(str);
                        Allure.addAttachment("Response", str);
                    } catch (ParseException e) {
                        json = null;
                    }
                    array[1] = json;
                }
                return array;
            });

        } catch (IOException e) {
            result = null;
        }
        return result;
    }

    public Object[] add(StringEntity payload) {
        Object[] result;
        Allure.addAttachment("Request", " POST https://petstore.swagger.io/v2/pet/");
        try {
            Allure.addAttachment("Payload", new String(payload.getContent().readAllBytes(), StandardCharsets.UTF_8));
        } catch (IOException e) { }
        try (CloseableHttpClient httpclient = HttpClients.createDefault()) {

            ClassicHttpRequest httpPost = ClassicRequestBuilder
                    .post("https://petstore.swagger.io/v2/pet/")
                    .addHeader("Content-Type", "application/json")
                    .addHeader("accept", "application/json")
                    .setEntity(payload)
                    .build();
            result = httpclient.execute(httpPost, response -> {
                Object[] array = new Object[2];
                array[0] = response.getCode();
                final HttpEntity entity = response.getEntity();
                if (entity != null) {
                    JSONParser parser = new JSONParser();
                    JSONObject json;
                    try {
                        String str = EntityUtils.toString(entity);
                        json = (JSONObject) parser.parse(str);
                        Allure.addAttachment("Response", str);
                    } catch (ParseException e) {
                        json = null;
                    }
                    array[1] = json;
                }
                return array;
            });
        } catch (IOException e) {
            result = null;
        }
        return result;
    }

    public Object[] delete(int id) {
        Object[] result;
        Allure.addAttachment("Request", " DELETE https://petstore.swagger.io/v2/pet/" + String.valueOf(id));
        try (CloseableHttpClient httpclient = HttpClients.createDefault()) {
            ClassicHttpRequest httpDel = ClassicRequestBuilder
                    .delete("https://petstore.swagger.io/v2/pet/" + String.valueOf(id))
                    .build();
            result = httpclient.execute(httpDel, response -> {
                Object[] array = new Object[2];
                array[0] = response.getCode();
                final HttpEntity entity = response.getEntity();
                if (entity != null) {
                    JSONParser parser = new JSONParser();
                    JSONObject json;
                    try {
                        String str = EntityUtils.toString(entity);
                        json = (JSONObject) parser.parse(str);
                        Allure.addAttachment("Response", str);
                    } catch (ParseException e) {
                        json = null;
                    }
                    array[1] = json;
                }
                return array;
            });

        } catch (IOException e) {
            result = null;
        }
        return result;
    }

    public static void main(String[] args) {
        ArrayList<NameValuePair> payload = new ArrayList<NameValuePair>();
        payload.add(new BasicNameValuePair("id", "530"));
        payload.add(new BasicNameValuePair("name", "Cookie"));
        payload.add(new BasicNameValuePair("status", "sold"));
        
        int id = 530;
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":" + String.valueOf(530) + ",");
        json.append("\"name\":\"Cookie\",");
        json.append("\"status\":\"sold\"");
        json.append("}");
        System.out.println(json.toString());
        StringEntity data = new StringEntity(json.toString());
        Petstore store = new Petstore();
        JSONObject result = (JSONObject) store.get(id)[1];
        System.out.println(result.get("id"));
        Object[] res = store.add(data);
        System.out.println(String.valueOf(res[0]) + ' ' + res[1]);
        res = store.get(530);
        System.out.println(String.valueOf(res[0]) + ' ' + res[1]);

        System.out.println(((JSONObject) res[1]).get("id"));
        res = store.delete(530);
        System.out.println(String.valueOf(res[0]) + ' ' + res[1]);
        res = store.get(530);
        System.out.println(String.valueOf(res[0]) + ' ' + res[1]);
    }

}
