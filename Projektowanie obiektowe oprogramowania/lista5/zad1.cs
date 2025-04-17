namespace lista5;

using System.IO;
using System.Net.Mail;

public class SmtpFacade
{
  public void Send(string From, string To, string Subject, string Body, Stream Attachment, string AttachmentMimeType)
  {
    MailMessage mail = new MailMessage(From, To, Subject, Body);

    if (Attachment != null)
    {
      mail.Attachments.Add(new System.Net.Mail.Attachment(Attachment, AttachmentMimeType));
    }

    SmtpClient client = new SmtpClient();
    try
    {
      client.Send(mail);
    }
    catch (Exception exception)
    {
      Console.WriteLine("Error: " + exception);
    }
  }
}
