package entidade;

import java.sql.*;

public class Pessoa {

    public Integer id;
    public String nome;
    public String senha;
    public String email;
    public String endereco;
    public String telefone;
    public String ativo;

    public static Pessoa from(ResultSet resultSet) throws SQLException {

        Pessoa p = new Pessoa();

        p.id = resultSet.getInt("id");
        p.nome = resultSet.getString("nome");
        p.senha = resultSet.getString("senha");
        p.email = resultSet.getString("email");
        p.endereco = resultSet.getString("endereco");
        p.telefone = resultSet.getString("telefone");
        p.ativo = resultSet.getString("ativo");

        return p;
    }

    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();

        sb.append("pessoa{id=").append(id);
        sb.append("', nome='").append(nome);
        sb.append("', senha='").append(senha);
        sb.append("', email='").append(email);
        sb.append("', endereco='").append(endereco);
        sb.append("', telefone='").append(telefone);
        sb.append("', ativo='").append(ativo);
        sb.append('}');

        return sb.toString();
    }

}
