# NoSQL Database Analysis – FlexiMart

## Section A: Limitations of RDBMS (150 words)

MySQL and other relational databases function best when data has a consistent, stable structure. All rows must follow the same schema, and each table must have predetermined columns. In systems like FlexiMart, where products might have a wide range of characteristics, this becomes an issue. For instance, groceries need weight and expiration dates, whereas gadgets can need data like guarantee or battery life. Sparse tables, frequent schema changes, and faulty queries or reports result from adding new columns with every variant.

Because current queries, indexes, and apps rely on the outdated schema, changing table structures becomes hazardous and time-consuming as the company changes. Furthermore, similar data—like product reviews—must be divided into different columns and connected during queries, which increases complexity and lowers speed. These drawbacks demonstrate why flexible, rapidly evolving product catalogs are difficult for typical relational databases to handle.

## Section B: Benefits of MongoDB (150 words)

FlexiMart and other product-based systems benefit greatly from MongoDB's ability to manage dynamic and adaptable data structures. MongoDB stores data as documents, where each product is a single JSON-like object, rather than rows and tables. This eliminates the need for a set schema and permits various products to have distinct fields. Within the same collection, a grocery item can store expiration information and an electronic product can record specifications.

Product reviews can be integrated right into the product document, which improves read efficiency and removes the need for complicated joins. By spreading data across several servers, MongoDB also easily scales horizontally, which is helpful as the number of items and users increases. All things considered, MongoDB more closely resembles real-world product catalogs and facilitates quick creation and frequent modifications without requiring expensive schema migrations.

## Section C: Trade-offs of MongoDB (100 words)

MongoDB has trade-offs despite its flexibility. First, it is more difficult to execute complicated analytical queries across many collections since it does not allow joins as effectively as SQL databases. Reporting and business intelligence use cases may be hampered by this. Second, compared to conventional relational databases, MongoDB's transactional guarantees are lower. Transactions are supported, but they are typically less developed and more difficult to handle on a large scale. Because of these trade-offs, MongoDB is more appropriate for flexible, read-intensive workloads than for rigid transactional or financial systems.
