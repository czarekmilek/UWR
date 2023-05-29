import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.border.BevelBorder;

public class PublicationSwing extends Frame implements ActionListener {

    JPanel pnPanel0;
    JPanel pnPanel1;
    JLabel lbLabel3;
    JLabel lbLabel4;
    JLabel lbLabel5;
    JLabel lbLabel6;
    JLabel lbLabel7;
    JLabel lbLabel8;
    JButton btBut5;
    JTextField tfText0;
    JTextField tfText1;
    JTextField tfText2;
    JTextField tfText3;
    JTextField tfText4;
    JTextField tfText5;
    public  PublicationSwing(Publication publication) {
        JFrame frame = new JFrame("Edycja Publikacji");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        pnPanel0 = new JPanel();
        GridBagLayout gbPanel0 = new GridBagLayout();
        GridBagConstraints gbcPanel0 = new GridBagConstraints();
        pnPanel0.setLayout(gbPanel0);

        pnPanel1 = new JPanel();
        pnPanel1.setBorder(BorderFactory.createTitledBorder("Publication"));
        GridBagLayout gbPanel1 = new GridBagLayout();
        GridBagConstraints gbcPanel1 = new GridBagConstraints();
        pnPanel1.setLayout(gbPanel1);

        lbLabel3 = new JLabel("Autor");
        gbcPanel1.gridx = 0;
        gbcPanel1.gridy = 0;
        gbcPanel1.gridwidth = 7;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 1;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(lbLabel3, gbcPanel1);
        pnPanel1.add(lbLabel3);

        lbLabel4 = new JLabel("nazwa");
        gbcPanel1.gridx = 0;
        gbcPanel1.gridy = 2;
        gbcPanel1.gridwidth = 7;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 1;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(lbLabel4, gbcPanel1);
        pnPanel1.add(lbLabel4);

        lbLabel5 = new JLabel("cena");
        gbcPanel1.gridx = 0;
        gbcPanel1.gridy = 4;
        gbcPanel1.gridwidth = 7;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 1;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(lbLabel5, gbcPanel1);
        pnPanel1.add(lbLabel5);

        lbLabel6 = new JLabel("Rok wydania");
        gbcPanel1.gridx = 0;
        gbcPanel1.gridy = 6;
        gbcPanel1.gridwidth = 7;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 1;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(lbLabel6, gbcPanel1);
        pnPanel1.add(lbLabel6);

        lbLabel7 = new JLabel("Naukowy?");
        gbcPanel1.gridx = 0;
        gbcPanel1.gridy = 8;
        gbcPanel1.gridwidth = 7;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 1;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(lbLabel7, gbcPanel1);
        pnPanel1.add(lbLabel7);

        lbLabel8 = new JLabel("Uczelniany?");
        gbcPanel1.gridx = 0;
        gbcPanel1.gridy = 10;
        gbcPanel1.gridwidth = 7;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 1;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(lbLabel8, gbcPanel1);
        pnPanel1.add(lbLabel8);


        tfText0 = new JTextField(publication.name, 40);
        gbcPanel1.gridx = 7;
        gbcPanel1.gridy = 0;
        gbcPanel1.gridwidth = 8;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 0;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(tfText0, gbcPanel1);
        pnPanel1.add(tfText0);

        tfText1 = new JTextField(publication.author, 40);
        gbcPanel1.gridx = 7;
        gbcPanel1.gridy = 2;
        gbcPanel1.gridwidth = 8;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 0;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(tfText1, gbcPanel1);
        pnPanel1.add(tfText1);

        tfText2 = new JTextField(Integer.toString(publication.prize),40);
        gbcPanel1.gridx = 7;
        gbcPanel1.gridy = 4;
        gbcPanel1.gridwidth = 8;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 0;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(tfText2, gbcPanel1);
        pnPanel1.add(tfText2);


        tfText3 = new JTextField(Integer.toString(publication.releaseYear),40);
        gbcPanel1.gridx = 7;
        gbcPanel1.gridy = 6;
        gbcPanel1.gridwidth = 8;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 0;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(tfText3, gbcPanel1);
        pnPanel1.add(tfText3);

        tfText4 = new JTextField(Boolean.toString(publication.aboutScience),40);
        gbcPanel1.gridx = 7;
        gbcPanel1.gridy = 8;
        gbcPanel1.gridwidth = 8;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 0;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(tfText4, gbcPanel1);
        pnPanel1.add(tfText4);

        tfText5 = new JTextField(Boolean.toString(publication.forStudents),40);
        gbcPanel1.gridx = 7;
        gbcPanel1.gridy = 10;
        gbcPanel1.gridwidth = 8;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 0;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints(tfText5, gbcPanel1);
        pnPanel1.add(tfText5);



        gbcPanel0.gridx = 0;
        gbcPanel0.gridy = 0;
        gbcPanel0.gridwidth = 20;
        gbcPanel0.gridheight = 20;
        gbcPanel0.fill = GridBagConstraints.BOTH;
        gbcPanel0.weightx = 1;
        gbcPanel0.weighty = 0;
        gbcPanel0.anchor = GridBagConstraints.NORTH;
        gbPanel0.setConstraints(pnPanel1, gbcPanel0);
        pnPanel0.add(pnPanel1);

        btBut5 = new JButton( "Zapisz"  );
        gbcPanel1.gridx = 0;
        gbcPanel1.gridy = 12;
        gbcPanel1.gridwidth = 15;
        gbcPanel1.gridheight = 2;
        gbcPanel1.fill = GridBagConstraints.BOTH;
        gbcPanel1.weightx = 1;
        gbcPanel1.weighty = 0;
        gbcPanel1.anchor = GridBagConstraints.NORTH;
        gbPanel1.setConstraints( btBut5, gbcPanel1 );
        pnPanel1.add( btBut5 );
        btBut5.addActionListener(this);


        pnPanel0.setBackground(Color.CYAN);
        pnPanel0.setOpaque(false);
        pnPanel0.setBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED));
        pnPanel0.setBorder(BorderFactory.createEtchedBorder());
        pnPanel0.setBorder(BorderFactory.createLineBorder(Color.RED));
        pnPanel0.setBorder(BorderFactory.createTitledBorder("Edycja Publikacji"));
        pnPanel0.setVisible(true);
        frame.add(pnPanel0);
        frame.pack();
        frame.setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String name = tfText0.getText();
        String author = tfText1.getText();
        int prize = Integer.parseInt(tfText2.getText());
        int release = Integer.parseInt(tfText3.getText());
        boolean science = Boolean.parseBoolean(tfText4.getText());
        boolean students = Boolean.parseBoolean(tfText5.getText());
        Book publication =new Publication(name,prize,author,release,science,students);
        publication.save("Publication.txt");
    }
}
