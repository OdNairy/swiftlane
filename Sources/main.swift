import Foundation
import Result
import SwiftyJSON

let sessionConfiguration = URLSessionConfiguration.default
sessionConfiguration.useProxyIfAvailable()

let session = URLSession(configuration:sessionConfiguration, delegate: SessionDelegate(), delegateQueue: nil)


let result = session.run("https://itunesconnect.apple.com/itc/static-resources/controllers/login_cntrl.js")

let data = ["accountName":"roman.gardukevich@intellectsoft.net",
            "password":"WTJVj7dp>Y>}FaX8",
            "rememberMe":true].toJSONData()

let defaultRequestHeaders = ["Content-Type":"application/json",
                             "X-Requested-With":"XMLHttpRequest",
                             "Accept":"application/json, text/javascript"]

guard let itunesServiceKey = re.compile("itcServiceKey = '(.*)'").search(result.data!)?.group(1) else {
    print("")
    exit(-1)
}
print("itunes service key = \(itunesServiceKey)")

var authRequest = URLRequest(url: URL(string: "https://idmsa.apple.com/appleauth/auth/signin?widgetKey=\(itunesServiceKey)")!)
authRequest.httpMethod = "POST"
authRequest.httpBody = data
authRequest.allHTTPHeaderFields = defaultRequestHeaders
session.run(authRequest)

dump(HTTPCookieStorage.shared.cookies)

session.run("https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/wa/route?noext=true")

// List Teams
session.run(method: "POST", url: "https://developerservices2.apple.com/services/\(protocolVersion)/listTeams.action", headers: nil)

let teamId = "5U67EGLCUP"

// Members (Admins and usual. No invites here)
session.run(method: "POST", url: "https://developer.apple.com/services-account/\(protocolVersion)/account/getTeamMembers",
            data: ["teamId":teamId])

let resp = session.run(method: "POST",
            url: "https://developerservices2.apple.com/services/\(protocolVersion)/ios/listProvisioningProfiles.action?includeInactiveProfiles=true&onlyCountLists=true&teamId=\(teamId)", headers: nil)
let plist = try? PropertyListSerialization.propertyList(from: resp.data!.data(using: .utf8)!, options: [], format: nil) as! [String:Any]
guard let plist = plist else {exit(-1)}
print(plist["provisioningProfiles"]!)

print(plist)


//r.params = {
//    teamId: team_id,
//    includeInactiveProfiles: true,
//    onlyCountLists: true
//}


