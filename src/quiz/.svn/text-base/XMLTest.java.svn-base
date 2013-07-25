package quiz;

import static org.junit.Assert.*;

import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.stream.FactoryConfigurationError;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.junit.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/** 
 * Test writing XML using javax.xml
 * @author rglobus
 *
 */
public class XMLTest {

	/**
	 * Test writing small XML file
	 */
	@Test
	public void test() {
		StringWriter stringWriter = new StringWriter();
		try {
			XMLStreamWriter xmlWriter = XMLOutputFactory.newInstance().createXMLStreamWriter(stringWriter);
			xmlWriter.writeStartDocument();
			
				xmlWriter.writeStartElement("question");
				xmlWriter.writeAttribute("type", "picture-response");
					xmlWriter.writeStartElement("image-location");
						xmlWriter.writeCharacters("http://m.com/?r=5&t=3&z=10");
					xmlWriter.writeEndElement();
				xmlWriter.writeEndElement();
			
			xmlWriter.writeEndDocument();
		} catch (XMLStreamException e) {
			e.printStackTrace();
		} catch (FactoryConfigurationError e) {
			e.printStackTrace();
		}
		String xml = stringWriter.toString();
		System.out.println(xml);
	}
	
	@Test
	public void testEscape() {
		assertEquals(AbstractQuestion.escape("hi"), "hi");
		assertEquals(AbstractQuestion.escape("14 < 5, but Ryan & I love soccer"), "14 &lt; 5, but Ryan &amp; I love soccer");
		assertEquals(AbstractQuestion.escape("\"Hi,\" she said."), "\"Hi,\" she said.");
		assertEquals(AbstractQuestion.escape("if x <> y then r && s"), "if x &lt;&gt; y then r &amp;&amp; s");
		assertEquals(AbstractQuestion.escape(" &amp; "), " &amp;amp; ");
	}
	
	@Test
	public void testUnescape() {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		Document doc;
		try {
			DocumentBuilder parser = factory.newDocumentBuilder();
			doc = parser.parse(new InputSource(new StringReader("<speech id=\"elem\">hi, George &amp; Susie</speech>")));
			doc.getDocumentElement().normalize();
			NodeList nl = doc.getElementsByTagName("speech");
			System.out.println(nl.item(0).getTextContent());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testTransformer() {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		Document doc;
		try {
			DocumentBuilder parser = factory.newDocumentBuilder();
			doc = parser.parse(new InputSource(new StringReader("<question type=\"foo\"><query>Who?</query><answer>Me!</answer></question>")));
			doc.getDocumentElement().normalize();
			Node node = doc.getElementsByTagName("question").item(0);
			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
			StringWriter stringWriter = new StringWriter();
			transformer.transform(new DOMSource(node), new StreamResult(stringWriter));
			System.out.println(stringWriter.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
