package utility;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import entity.User;

import java.util.Properties;

public class EmailUtility {

    public static void sendEmail(String reciverEmail,User user) {

        final String username = "jsengn22@gmail.com"; // Mail Server
        final String password = "afme wuur hemo yhpp";// app password 

        Properties prop = new Properties();
    prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS
        
        Session session = Session.getInstance(prop,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
          String sender="jsengn22@gmail.com";
          String sendingMail=sender+","+reciverEmail;
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(sendingMail)
            );
            message.setSubject("Welcome To Login");
            message.setText("Dear,"+user.getName()
                    + "\n\n Your Registration is successful now!"
                    +"\n you can login here with your user Name:"+user.getName()
                    +" or with your email : "+user.getEmail());

            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}
