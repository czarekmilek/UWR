var neo4j = require('neo4j-driver');

// database connection
(async () => {
  const URI = 'neo4j+s://24b4e21f.databases.neo4j.io'
  const USER = 'neo4j'
  const PASSWORD = 'nHRXQAtyTEDgMoruTUqwG0cGj7xdrea_4mVNg2kT0Zg'
  let driver

  try {
    driver = neo4j.driver(URI, neo4j.auth.basic(USER, PASSWORD))
    const serverInfo = await driver.getServerInfo()
    console.log('Connection established')
    console.log(serverInfo)

    // query
    const { records, summary } = await driver.executeQuery(
        'MATCH (n:Person) RETURN n',
        )

    console.log(
        `>> The query ${summary.query.text} ` +
        `returned ${records.length} records ` +
        `in ${summary.resultAvailableAfter} ms.`
    )

    console.log('>> Results')
    const tableData = records.map(record => {
        return { id: record.get('n').elementId, name: record.get('n').properties.name };
    });
    console.table(tableData)
    // console.log(tableData)

  } catch(err) {
    console.log(`Connection error\n${err}\nCause: ${err.cause}`)
  } finally {
    if (driver){
        driver.close()
    }
  }
})();