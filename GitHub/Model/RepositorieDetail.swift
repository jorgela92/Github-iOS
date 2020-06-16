//
//  RepositorieDetail.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 12/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation


// MARK: - RepositorieDetail
struct RepositorieDetail: StructDecodable {
    let id, size, stargazersCount, watchersCount, forksCount, openIssuesCount, forks, openIssues, watchers, networkCount, subscribersCount: Int?
    let repositorieDetailPrivate, fork, hasIssues, hasProjects, hasDownloads, hasWiki, hasPages, archived, disabled: Bool
    let owner: Owner?
    let nodeID, name, fullName, htmlURL, repositorieDetailDescription, url, forksURL, keysURL, collaboratorsURL, teamsURL, hooksURL, issueEventsURL, eventsURL, assigneesURL, branchesURL, tagsURL, blobsURL, gitTagsURL, gitRefsURL, treesURL, statusesURL, languagesURL, stargazersURL, contributorsURL, subscribersURL, subscriptionURL, commitsURL, gitCommitsURL, commentsURL, issueCommentURL, contentsURL, compareURL, mergesURL, archiveURL, downloadsURL, issuesURL, pullsURL, milestonesURL, notificationsURL, labelsURL, releasesURL, deploymentsURL, createdAt, updatedAt, pushedAt, gitURL, sshURL, cloneURL, svnURL, homepage, language, defaultBranch, mirrorURL, tempCloneToken: String?
    let license: License?
    let organization: Organization?

    enum CodingKeys: String, CodingKey {
        case id, name, owner, fork, url, homepage, size, language, archived, disabled, license, forks, watchers, organization
        case nodeID = "node_id"
        case fullName = "full_name"
        case repositorieDetailPrivate = "private"
        case htmlURL = "html_url"
        case repositorieDetailDescription = "description"
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
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case openIssuesCount = "open_issues_count"
        case openIssues = "open_issues"
        case defaultBranch = "default_branch"
        case tempCloneToken = "temp_clone_token"
        case networkCount = "network_count"
        case subscribersCount = "subscribers_count"
    }
}

// MARK: - Organization
struct Organization: Codable {
    let id: Int
    let login, nodeID, avatarURL, gravatarID, url, htmlURL, followersURL, followingURL, gistsURL, starredURL, subscriptionsURL, organizationsURL, reposURL, eventsURL, receivedEventsURL, type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id, url, type
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
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
        case siteAdmin = "site_admin"
    }
}
