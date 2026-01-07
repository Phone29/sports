package entity;

public class Product {
    private int productId;
    private String name;
    private double price;
    private int quantity;
    private String image;
    private int cId;

    
    public Product() {}

    public Product(int productId, String name, double price, int quantity, String image, int cId) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
        this.cId = cId;
    }

    
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public int getCid() { return cId; }
    public void setCid(int cId) { this.cId = cId; }

	public void setCategoryName(String string) {
		
		
	}
}
