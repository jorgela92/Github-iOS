//
//  Repositorie.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

// MARK: - RepositorieElement
struct RepositorieElement: Decodable {
    let id: Int
    let nodeID, name, fullName, url, forksURL, htmlURL, keysURL, collaboratorsURL, teamsURL, hooksURL, issueEventsURL, eventsURL, assigneesURL, branchesURL, tagsURL, blobsURL, gitTagsURL, gitRefsURL, treesURL, statusesURL, languagesURL, stargazersURL, contributorsURL, subscribersURL, subscriptionURL, commitsURL, gitCommitsURL, commentsURL, issueCommentURL, contentsURL, compareURL, mergesURL, archiveURL, downloadsURL, issuesURL, pullsURL, milestonesURL, notificationsURL, labelsURL, releasesURL, deploymentsURL: String
    let repositoriePrivate, fork: Bool
    let owner: Owner
    let repositorieDescription: String?
    
    static func getRepositoriesArray(_ dataResponse: Data) -> [RepositorieElement]? {
        do {
            return try JSONDecoder().decode([RepositorieElement].self, from: dataResponse)
        } catch {
            return nil
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, name, owner, fork, url
        case nodeID = "node_id"
        case fullName = "full_name"
        case repositoriePrivate = "private"
        case htmlURL = "html_url"
        case repositorieDescription = "description"
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let id: Int
    let login, nodeID, avatarURL, gravatarID, url, htmlURL, followersURL, followingURL, gistsURL, starredURL, subscriptionsURL, organizationsURL, reposURL, eventsURL, receivedEventsURL: String
    let type: TypeEnum
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
    
    func getTypeImage() -> UIImage? {
        switch self.type {
        case .user:
            return UIImage(named: "user")
        case .organization:
            return UIImage(named: "organization")
        }
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}
