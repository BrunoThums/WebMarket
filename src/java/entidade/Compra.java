package entidade;

import java.sql.*;

public class Compra {

    public Integer id;
    public double valorTotal;
    public Integer parcelas;
    public String created_at; 
    public Integer id_pessoa;
    

    public static Compra from(ResultSet resultSet) throws SQLException {
        Compra c = new Compra();

        c.id = (resultSet.getInt("id"));
        c.valorTotal = (resultSet.getDouble("valorTotal"));
        c.parcelas = (resultSet.getInt("parcelas"));
        c.created_at = (resultSet.getString("created_at"));
        c.id_pessoa = (resultSet.getInt("id_pessoa"));

        return c;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("compra{id=").append(id);
        sb.append("', valorTotal='").append(valorTotal);
        sb.append("', parcelas='").append(parcelas);
        sb.append("', created_at='").append(created_at);
        sb.append("', id_pessoa='").append(id_pessoa);
        sb.append('}');

        return sb.toString();
    }

}
