package entidade;

import java.sql.*;

public class Carrinho {


    public int id_compra;
    public int id_item;

    public static Carrinho from(ResultSet resultSet) throws SQLException {
        Carrinho carrinho = new Carrinho();

        carrinho.id_compra = resultSet.getInt("id_compra");
        carrinho.id_item = resultSet.getInt("id_item");

        return carrinho;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("carrinho={id_compra=").append(id_compra);
        sb.append("', id_item='").append(id_item);
        sb.append('}');
        return sb.toString();
    }

}