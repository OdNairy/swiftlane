import Foundation

print("Hello, world!")
let session = URLSession(configuration:URLSessionConfiguration.default)
let result = session.run("https://itunesconnect.apple.com/itc/static-resources/controllers/login_cntrl.js")

dump(result)
