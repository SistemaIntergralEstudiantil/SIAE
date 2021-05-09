/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import mx.com.siae.modelo.beans.Usuarios;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDMetadata;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

/**
 *
 * @author danielhernandezreyes
 */
public class Correo {
    
    private final String remitente = "dhernandezr@itsoeh.edu.mx";
    private final String password = "danielhernandez";
    private Properties properties;
    private MimeMessage mimeMessage;
    private Session session;
    private Transport transport;
    private PDDocument document;
    private PDPageContentStream contentStream;
    /**
     * Método genera un correo al alumno con la información de su carga academica.
     * @param destino
     * @throws MessagingException En la espesificación del destinatario
     * @throws UnsupportedEncodingException En la espesificación del contenido del correo
     */
    public void generar(Usuarios destino, String txt) throws MessagingException, UnsupportedEncodingException, IOException {
        // La configuración para enviar correo
        generarPDF(destino,txt);
        generarPropiedades();
        session = Session.getInstance(properties, null);
        generarMensaje(destino);
    }
    /**
     * Método envia el correo al alumno.
     * @throws MessagingException En la espesificación del destinatario
     */
    public void enviar() throws MessagingException {
        // Enviar el mensaje
        transport = session.getTransport("smtp");
        transport.connect(remitente, password);
        transport.sendMessage(mimeMessage, mimeMessage.getRecipients(Message.RecipientType.TO));
        transport.close();
    }
    /**
     * Método genera el encabezado de la conexión del correo.
     */
    private void generarPropiedades() {
        properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.user", remitente);
        properties.put("mail.password", password);
    }
    /**
     * Método genera el cuerpo del correo.
     * @param destino La direccón del destinatario
     * @throws MessagingException En la espesificación del destinatario
     * @throws UnsupportedEncodingException En la espesificación del contenido del correo
     */
    private void generarMensaje(Usuarios destino) throws MessagingException, UnsupportedEncodingException {
        mimeMessage = new MimeMessage(session); // Cuerpo del mensaje
        mimeMessage.setFrom(new InternetAddress(remitente, "Sistema Integral de Atención Estudiantil"));
        // Agregar los destinatarios al mensaje
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(destino.getCorreo_inst()));
        mimeMessage.setSubject("Asignatura de Alta"); // Asunto
        // Contenido del cuerpo
        Multipart multipart = new MimeMultipart();
        // adjunto 
        BodyPart bodyA = new MimeBodyPart(); // Creo la parte del mensaje
        File file = new File("document.pdf");
        
        bodyA.setDataHandler( new DataHandler(new FileDataSource(file)));
        bodyA.setFileName("Lista de altas.pdf");
        // Texto
        BodyPart bodyT = new MimeBodyPart(); // Creo la parte del mensaje
        bodyT.setText("Se comparte la lista de las asignaturas elegidas en su caga academica");
        multipart.addBodyPart(bodyT);
        multipart.addBodyPart(bodyA);        
        mimeMessage.setContent(multipart);
    }
    /**
     * Método se crea el el pdf con los datos del alumno y de las materias
     * @param user Datos del alumno
     * @param txt Cadena de texto con la información de las materias
     * @throws IOException Al crear el achivo PDF
     */
    private void generarPDF(Usuarios user, String txt) throws IOException {
        document = new PDDocument();
        PDPage page = new PDPage(PDRectangle.LETTER);
        document.addPage(page);
        contentStream = new PDPageContentStream(document, page);
        // Text
        document.setDocumentInformation(generarEncabezadoPDF());
        
        contentStream.setLeading(20f);
        contentStream.beginText();
        contentStream.setFont(PDType1Font.TIMES_BOLD, 18);
        contentStream.newLineAtOffset(40, page.getMediaBox().getHeight() - 40);
        contentStream.showText("SISTEMA INTEGRAL DE ATENCION ESTUDIANTIL");
        contentStream.newLine();
        contentStream.newLine();
        contentStream.setFont(PDType1Font.TIMES_BOLD, 14);
        contentStream.showText("Datos del alumno:");
        contentStream.showText("Nombre: "+user.getNombreCompleto());
        contentStream.newLine();
        contentStream.showText("Matricula: "+user.getIdUsuario());
        contentStream.newLine();
        contentStream.showText("Semestre: "+user.getSemestre());
        contentStream.newLine();
        contentStream.setFont(PDType1Font.TIMES_BOLD, 16);
        contentStream.newLine();
        contentStream.showText("Materias solicitadas en tu carga academica:");
        contentStream.newLine();
        contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
        String data[] = txt.split(":");
        for (int i = 0; i < data.length; i++) {
            String d[] = data[i].split(",");
            String idCurso = new String(d[0].getBytes(Charset.forName("ISO-8859-1")));
            String asignatura = new String(d[1].getBytes(Charset.forName("ISO-8859-1")));
            contentStream.showText(" IdCurso: "+idCurso +" < > Asignatura:"+ asignatura);
            contentStream.newLine();
        }
        contentStream.endText();
    }
    
    public void closePDF() throws IOException {
        contentStream.close();
        document.save("document.pdf");
    }
    
    private PDDocumentInformation generarEncabezadoPDF() {
        PDDocumentInformation info = new PDDocumentInformation();
        info.setAuthor("Sistema Integral de Atención Estudiantil");
        info.setTitle("Listado de academica");
        info.setSubject("Informar");
        info.setCreator("SIAE");
        return info;
    }
    
    
}
