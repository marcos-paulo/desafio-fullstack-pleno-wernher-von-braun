// import java.io.InputStream;
// import java.io.PrintStream;
// import org.apache.commons.net.telnet.TelnetClient;

// public class TelnetExample {
// public static void main(String[] args) {
// // Endereço IP e porta do dispositivo Telnet
// String host = "endereco_ip_do_dispositivo";
// int port = 23; // Porta Telnet padrão

// // Comando a ser enviado
// String comando = "comando_a_ser_enviado";

// // Estabelece a conexão Telnet
// try (TelnetClient telnetClient = new TelnetClient()) {
// telnetClient.connect(host, port);

// // Obter os fluxos de entrada e saída
// InputStream inputStream = telnetClient.getInputStream();
// PrintStream outputStream = new PrintStream(telnetClient.getOutputStream());

// // Enviar o comando
// outputStream.println(comando);
// outputStream.flush();

// // Aguardar e ler a resposta
// byte[] buffer = new byte[1024];
// int bytesRead = inputStream.read(buffer);
// String resposta = new String(buffer, 0, bytesRead);
// System.out.println("Resposta do dispositivo: " + resposta);

// // Fechar a conexão Telnet
// telnetClient.disconnect();
// } catch (Exception e) {
// e.printStackTrace();
// }
// }
// }


// <dependency>
// <groupId>commons-net</groupId>
// <artifactId>commons-net</artifactId>
// <version>3.8.0</version> <!-- ou a versão mais recente -->
// </dependency>