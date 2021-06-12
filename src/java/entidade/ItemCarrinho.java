package entidade;

import java.sql.*;

public class ItemCarrinho {

    public Integer id;
    public int quant;
    public double precoTotal;
    public double valorUnit;
    public String created_at; 
    public Integer id_produto;

    public static ItemCarrinho from(ResultSet resultSet) throws SQLException {
        ItemCarrinho itemCar = new ItemCarrinho();

        itemCar.id = resultSet.getInt("id");
        itemCar.quant = resultSet.getInt("quant");
        itemCar.valorUnit = resultSet.getDouble("valorUnit");
        itemCar.id_produto = resultSet.getInt("id_produto");
        itemCar.created_at = resultSet.getString("created_at"); 

        return itemCar;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("itemCarrinho{id=").append(id);
        sb.append("', quant='").append(quant);
        sb.append("', valorUnit='").append(valorUnit);
        sb.append("', id_produto='").append(id_produto);
        sb.append("', created_at='").append(created_at);
        sb.append('}');

        return sb.toString();
    }
}