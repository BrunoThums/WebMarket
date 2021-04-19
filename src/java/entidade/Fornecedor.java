package entidade;

import java.sql.*;

public class Fornecedor {

    public Integer id;
    public String nome;
    public String email;
    public String endereco;
    public String telefone;
    public String ativo;

    public static Fornecedor from(ResultSet resultSet) throws SQLException {

        Fornecedor fornec = new Fornecedor();

        fornec.id = resultSet.getInt("id");
        fornec.nome = resultSet.getString("nome");
        fornec.email = resultSet.getString("email");
        fornec.endereco = resultSet.getString("endereco");
        fornec.telefone = resultSet.getString("telefone");
        fornec.ativo = resultSet.getString("ativo");

        return fornec;
    }

    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();

        sb.append("fornecedor{id=").append(id);
        sb.append("', nome='").append(nome);
        sb.append("', email='").append(email);
        sb.append("', endereco='").append(endereco);
        sb.append("', telefone='").append(telefone);
        sb.append("', ativo='").append(ativo);
        sb.append('}');

        return sb.toString();
    }

}
